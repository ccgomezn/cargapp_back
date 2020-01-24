# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize!, except: %i[create login email_verify phone_verify validate_number resend_code new_password reset_password]
  before_action :set_user

  swagger_controller :users, 'User Management'

  swagger_api :index do
    summary 'Fetches all User items'
    notes 'This lists all the users'
  end

  swagger_api :active do
    summary 'Fetches active User items'
    notes 'This lists active the users'
  end

  swagger_api :email_verify do
    summary 'Verify email'
    param :form, 'user[email]', :string, :required, 'Email'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :phone_verify do
    summary 'Verify phone'
    param :form, 'user[phone_number]', :string, :required, 'Phone'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :truora_users do
    summary 'Get Truora users'
    response :unauthorized
  end

  swagger_api :create do
    summary 'Creates a new User'
    param :form, 'user[email]', :string, :required, 'Email'
    param :form, 'user[password]', :string, :required, 'Password'
    param :form, 'user[password_confirmation]', :string, :required, 'Password confirmation'
    param :form, 'user[phone_number]', :string, :optional, 'Phone number'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :validate_number do
    summary 'Validate phone number'
    param :form, 'user[phone_number]', :string, :required, 'Phone'
    param :form, 'user[mobile_code]', :string, :required, 'Code'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :login do
    summary 'Login'
    param :form, 'user[email]', :string, :required, 'Email'
    param :form, 'user[password]', :string, :required, 'Password'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :update_password do
    summary 'Update password'
    param :form, 'user[password_comfirmation]', :string, :required, 'Password confirmation'
    param :form, 'user[password]', :string, :required, 'Password'
    response :unauthorized
    response :not_acceptable
  end

  swagger_api :me do
    summary 'Shows mine existing User-Role'
    response :unauthorized
    response :not_found
  end

  swagger_api :truora_user do
    summary 'Shows Truora user'
    param :path, :id, :integer, :optional, 'User Id'
    response :unauthorized
    response :not_found
  end

  swagger_api :truora_check_user do
    summary 'Check Truora user'
    param :form, 'user[user_id]', :string, :required, 'Password confirmation'
    response :unauthorized
    response :not_found
  end

  # Metodo para buscar usuario y envias codigo para restaurar el password
  def reset_password
    user = User.find_by(email: params[:user][:email])
    if user
      code = user.send_reset_password_instructions
      user.update(pin: code)
      @parameter = Parameter.find_by(code: ENV['PHONE'])
      if params[:user][:notify].eql?(@parameter.value)
        @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT_SID'], ENV['TWILLIO_AUT_TOKEN']
        @client.api.account.messages.create(from: ENV['TWILLIO_FROM'], to: "+#{user.phone_number}", body: "Hola tu codigo para recuperar la contraseña es: #{code}")
        result = { "message": "Sending code to phone #{code}" }
        # render json: result
      else
        result = { "message": 'Sending url yo email' }
        # render json: user, status: :found
      end
      render json: result
    else
      result = { "message": 'Email is not valid' }
      render json: result, status: :unprocessable_entity
    end
  end

  def new_password
    # Valido email y token para cambiar el password
    user = User.find_by(email: params[:user][:email])
    params_pin = params[:user][:pin]
    new_password = params[:user][:new_password]
    new_password_confirmation = params[:user][:new_password_confirmation]

    if user.pin.eql?(params_pin) && new_password.eql?(new_password_confirmation) # validar el password
      user = user.reset_password(new_password, new_password_confirmation)
      result = { "message": 'Password update' }
      render json: result
    else
      # reponder con otro codigo de error
      result = { "message": 'The code or password is not correct' }
      render json: result, status: :unprocessable_entity
    end
  end

  def index
    @users = User.all
    render json: @users
    # render json: { "name": 'hola'}, status: :created
  end

  def check
    roles = []
    @user.user_roles.each do |role|
      roles << role.role
    end

    # Busco los modelos de los roles
    models = []
    @user.user_roles.each do |role|
      role.role.permissions.each do |model|
        models << model.cargapp_model
      end
    end

    @models = CargappModel.where(id: models.uniq.pluck(:id))
    @relations_obj = []
    @models.each do |model|
      # "#{model.value}".classify.singularize.classify.constantize.all
      # @obj << "#{model.value}".classify.singularize.classify.constantize.all
      # @obj << model_find_by_user("#{model.value}", @user.id) || model_all("#{model.value}")
      # @obj << {"#{model.value}": model_all("#{model.value}")}
      next unless model.value.to_s.classify.singularize.classify != 'Status'

      if model.value.to_s.classify.singularize.classify.constantize.has_attribute?('user_id')
        if model_find_by_user(model.value.to_s, @user.id)
          if !model_find_by_user(model.value.to_s, @user.id).empty?
            @relations_obj << { name: model.value, permission: true } # , data: model_find_by_user("#{model.value}", @user.id) }
          else
            @relations_obj << { name: model.value, permission: false } # , data: model_find_by_user("#{model.value}", @user.id) }
          end
        else
          @relations_obj << { name: model.value, permission: false } # , data: nil}
        end
      end
    end

    render json: @relations_obj
  end

  def active
    @users = User.where(active: true)
    render json: @users
    # render json: { "name": 'hola'}, status: :created
  end

  def email_verify
    user = User.find_by(user_email_params)
    if user && user.email.eql?(params[:user][:email])
      user = { email: true, message: 'exist' }
      render json: user, status: :ok
    else
      user = { email: false, message: 'does not exist' }
      render json: user, status: :found
    end
  end

  def phone_verify
    user = User.find_by(user_phone_params)
    puts '---------------------'
    puts user.to_json
    if user && user.phone_number.eql?(params[:user][:phone_number])
      user = { phone_number: true, message: 'exist' }
      render json: user, status: :ok
    else
      user = { phone_number: false, message: 'does not exist' }
      render json: user, status: :found
    end
  end

  def resend_code
    user = User.find_by(phone_number: params[:user][:phone_number])
    if user && user.phone_number.eql?(params[:user][:phone_number])
      # Genero el nuevo codigo
      number_randon = [(0..9)].map(&:to_a).flatten
      mobile_code = (0...4).map { number_randon[rand(number_randon.length)] }.join
      # Actualizo el codigo
      user.update(mobile_code: mobile_code)
      # Envio el nuevo mensaje con el nuevo codigo
      new_code(user.phone_number, mobile_code)
      user = { phone_number: true, message: 'code send' }
      render json: user, status: :ok
    else
      user = { phone_number: false, message: 'does not exist' }
      render json: user, status: :found
    end
  end

  # Falta en la migracion agregar la confirmacion de cuentas del devise
  def validate_number
    user = User.find_by(user_verify_phone_params)
    if user
      message = if user.active && user.mobile_verify
                  'it has already been validated'
                else
                  'user validate'
                end
      user.update(mobile_verify: true, active: true, confirmed_at: Time.new)
      render json: user = { user: user, message: message }
    else
      user = { user: user, message: 'not found' }
      render json: user, status: :found
    end
  end

  def active
    if @user
      @user.update(online: params['user']['online'])
      render json: @user, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  def create
    @user = User.new(user_params)
    $error_tw ||= false

    if @user.save && !$error_tw
      user_role
      profile
      # password definido por el atribut
      render json: @user, status: :created
    else
      if $error_tw
        data = { message: 'error twillio' }
        render json: data, status: :created
      else
        # head(:unprocessable_entity)
        render json: @user.errors, status: :unprocessable_entity
      end
    end
    $error_tw = false
  end

  def login
    client = OAuth2::Client.new(ENV['APP'], ENV['SECREPP_APP'], site: ENV['URL'])
    begin
      token = client.password.get_token(params['user']['email'], params['user']['password'])
      # token_reponse = { token: token, user: @user}
      @user = User.find_by(email: params['user']['email'])
      if @user.active && @user.mobile_verify
        render json: token, status: :ok
      else
        reponse = { user: nil, message: 'Usuario no activado o verificado' }
        render json: reponse, status: :unauthorized
      end
    rescue OAuth2::Error => e
      reponse = { user: nil, message: 'La contraseña o el correo es incorrecto' }
      render json: reponse, status: :unauthorized
    end
  end

  def update_password
    # @user = User.find_by(email: params["user"]["email"]) || User.find_by(phone_number: params["user"]["phone_number"])
    if @user.valid_password?(params[:user][:current_password])
      if @user.update(user_password_params)
        # Sign in the user by passing validation in case their password changed
        bypass_sign_in(@user)
        render json: @user, status: :ok
      else
        head(:unprocessable_entity)
      end
    else
      object_instance = {
        user: @user,
        message: 'incorrect current password '
      }
      render json: object_instance, status: :not_modified
    end
  end

  def me
    if @user
      roles = []
      permissions = []
      @user.user_roles.each do |role|
        permissions = []
        role.role.permissions.each do |permission|
          obj = {
            id: permission.id,
            cargapp_model: permission.cargapp_model.as_json(only: %i[name id]),
            action: permission.action, method: permission.method,
            allow: permission.allow, user_id: permission.user_id,
            active: permission.active, created_at: permission.created_at,
            updated_at: permission.updated_at
          }
          permissions << obj
        end

        obj = {
          id: role.id, role_id: role.role.id, admin_id: role.admin_id,
          name: role.role.name, description: role.role.description,
          active: role.active && role.role.active,
          created_at: role.created_at, updated_at: role.updated_at,
          permissions: permissions
        }
        roles << obj
      end

      # PAra tomar tiempos y distancias toca agregar variable<
      top = @user.services.where(statu_id: 2)
      @obj = {
        user: @user,
        top: top,
        roles: roles
        # profile: @user.profile
      }

      render json: @obj, status: :ok
    else
      head(:unprocessable_entity)
    end
  end

  def top
    @user_challenges = @user.user_challenges.where(active: true)
    points = @user_challenges.map(&:point).inject(0, &:+)

    # users = UserChallenge.order(:point)
    # users = User.joins(:user_challenges).where(user_challenges: { user_id: 1 })
    # users = UserChallenge.where(created_at: (Time.now - 30.day)..Time.now)
    # users = UserChallenge.where(active: true).or(UserChallenge.where(user_id: [1]))
    # users = UserChallenge.select(:user_id).distinct
    # users = UserChallenge.select("user_id as user_id, sum(point) as total_points").group("user_id")
    users_select = UserChallenge.select('user_id as user_id, sum(point) as total_points').group('user_id')
    users_all = users_select.where(active: true).order(total_points: :desc)
    users = []
    position = 0
    my_position = 0
    users_all.each do |user|
      user_services = Service.where(active: true, statu_id: 11, user_id: user.user_id)
      total_km = 0.0
      user_services.each do |service|
        total_km += service.distance || 0.0
      end

      name = user.user.profile ? !user.user.profile.firt_name.eql?('') ?
        user.user.profile.firt_name :  user.user.email : user.user.email
      users << { user_id: user.user_id, name: name, points: user.total_points,
                 position: position += 1, kilometres: total_km }

      my_position = position if user.user.email.eql?(@user.email)
    end

    me_user_services = Service.where(active: true, statu_id: 11, user_id: @user.id)
    me_total_km = 0.0
    me_user_services.each do |service|
      me_total_km += service.distance || 0.0
    end

    me = { my_points: points, position: my_position, kilometres: me_total_km,
           user_id: @user.id }

    @obj = { me: me, users: users }
    render json: @obj
  end

  def statistics
    services = Service.where(user_driver_id: @user.id, active: true, statu_id: 11)
    challengers = UserChallenge.where(user_id: @user.id, active: true)
    kilometres = 0
    points = 0
    score = 0.0
    services.each do |service|
      kilometres +=  service.distance || 0.0
      if service.rate_service
        score += service.rate_service.driver_point || 0.0
      end
    end

    challengers.each do |challenger|
      points +=  challenger.point || 0.0
    end
    reponde = {
      total_services: services ? services.count : 0,
      kilometres: kilometres,
      challenges: challengers ? challengers.count : 0,
      point: points,
      score: score.to_f / services ? services.count.to_f : 0.0
    }

    render json: reponde
  end

  def show
    @user_id = User.find_by(id: set_show_user)
    render json: @user_id, status: :ok
  end

  def truora_users
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Get.new(uri)
    request['Truora-Api-Key'] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  # Send { "user": { "id": 1 }  }
  def truora_user
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks/#{params[:id]}/details")
    request = Net::HTTP::Get.new(uri)
    request['Truora-Api-Key'] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  def truora_check_user
    user = User.find_by(check_user_params)
    if user.identification.eql?(user.profile ? user.profile.document_id.to_s : nil)
      if user.identification
        vehicle = user.vehicles.where(active: true).first
        check = params[:user][:force_creation] || false
        check = check_user(user, vehicle, check) if vehicle
      end
      check = JSON.parse(check.to_s)

      # puts check['check']['check_id']
      # user.update(check_id: check['check']['check_id'] )

      response =  {
        menssaje: 'in process of validation',
        check: check,
        user: user
      }

      render json: response
    else
      response =  {
        menssaje: 'validate your identification',
        user_identification: user.identification,
        profile_document: user.profile ? user.profile.document_id : nil
      }
      render json: response
    end
  end

  def check_user(user, vehicle, check)
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(country: 'co', type: 'vehicle', national_id: user.identification, license_plate: vehicle.plate, force_creation: check)
    request['Truora-Api-Key'] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    response.body
  end

  def truora_check_user_test
    uri = URI.parse("#{ENV['URL_TRUORA']}/checks")
    request = Net::HTTP::Post.new(uri)
    # request.set_form_data(country: 'co', type: 'person', national_id: '36835533', force_creation: true )
    # request.set_form_data(country: 'co', type: 'vehicle', national_id: '36835533', license_plate: 'VZB227',force_creation: true )
    request['Truora-Api-Key'] = ENV['TOKEN_TRUORA']

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    render json: response.body
  end

  # DELETE /user_documents/1
  # DELETE /user_documents/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    result = { user: params[:id], menssage: 'User was successfully destroyed.' }
    render json: result
  end

  def destroy_temporarily
    @user = User.find(params[:id])
    @user.update(active: false, online: false, mobile_verify: false)
    result = { user: @user, menssage: 'User was successfully destroyed temporarily.' }
    render json: result
  end

  private

  def model_all(model)
    # "#{model.value}".classify.singularize.classify.constantize.all
    model.to_s.classify.singularize.classify.constantize.all
  end

  def model_find_by_user(model, user)
    # "#{model.value}".classify.singularize.classify.constantize.all
    model.to_s.classify.singularize.classify.constantize.where(user: user)
  end

  def new_code(phone_number, mobile_code)
    @client = Twilio::REST::Client.new ENV['TWILLIO_ACCOUNT_SID'], ENV['TWILLIO_AUT_TOKEN']
    @client.api.account.messages.create(from: ENV['TWILLIO_FROM'], to: "+#{phone_number}", body: "Hola tu codigo de verificacion Cargapp es: #{mobile_code}")
  end

  def profile
    doct_type = DocumentType.find_by(code: ENV['DOC_TYPE_CC'])
    # Formatear el username
    profile = Profile.create(user_id: @user.id,
                             firt_name: params[:user][:username],
                             document_type_id: doct_type.id,
                             document_id: @user.identification,
                             phone: @user.phone_number)
    profile.save
  end

  def user_role
    role = Role.find_by(code: ENV['USER_C'])
    user_role = UserRole.create(user_id: @user.id,
                                role_id: params[:user][:role_id] || role.id,
                                admin_id: @user.id,
                                active: true)
    user_role.save
  end

  def set_show_user
    @user = User.find(params[:id])
  end

  def set_user
    @user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def user_email_params
    params.require(:user).permit(:email)
  end

  def check_user_params
    params.require(:user).permit(:id)
  end

  def user_phone_params
    params.require(:user).permit(:phone_number)
  end

  def user_verify_phone_params
    params.require(:user).permit(:phone_number, :mobile_code)
  end

  def user_password_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_login_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:password, :email)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :identification, :phone_number)
    # params.require(:user).permit(:email, :password, :password_confirmation, :identification, :phone_number, :username, :avatar)
  end

  def user_update_params
    params.require(:user).permit(:email, :username, :phone_number, :driver_referal_code)
  end
end
