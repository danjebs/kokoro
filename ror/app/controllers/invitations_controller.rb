class InvitationsController < DashboardController
  before_action :set_invitation, only: %i[show edit update destroy]
  before_action :initialize_invitation, only: %i[new create]
  before_action :set_breadcrumbs, only: %i[index new]

  def index
    authorize Invitation

    unscoped_invitations = Invitation
      .for_user(current_user)
      .status_is_pending
      .order(status: :asc, created_at: :desc)

    @invitations = policy_scope(unscoped_invitations)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @invitation.save
        InvitationMailer.invitation_email(@invitation).deliver_later
        format.html { redirect_to @invitation.collaborateable, notice: "Invitation was successfully created." }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    update_params = invitation_params.deep_dup()

    if current_user.email == @invitation.email
      update_params[:invitee_id] = current_user.id

      if @invitation.status_is_pending? && invitation_params[:status] == "accepted"
        @invitation.collaborateable.add_collaborator(current_user)
      end
    end

    respond_to do |format|
      if @invitation.update(update_params)
        redirect_target = @invitation.status_is_accepted? ? @invitation.collaborateable : invitations_url
        format.html { redirect_to redirect_target, notice: "Invitation was successfully updated." }
        format.json { render json: @invitation, status: :ok, location: @invitation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    collaborateable = @invitation.collaborateable
    @invitation.destroy!
    respond_to do |format|
      format.html { redirect_to collaborateable, status: :see_other, notice: "Invitation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])

    authorize @invitation
  end

  def initialize_invitation
    @invitation = Invitation.new(inviter: current_user, **invitation_params)

    authorize @invitation
  end

  def invitation_params
    return {} unless params[:invitation].present?

    params.require(:invitation).permit(:collaborateable_id, :collaborateable_type, :email, :status)
  end

  def set_breadcrumbs
    if action_name == "index"
      add_breadcrumb("Invitations", invitations_path)
    elsif action_name == "new"
      add_breadcrumb(@invitation.collaborateable.class.name.pluralize, boards_path)
      add_breadcrumb(@invitation.collaborateable.name, @invitation.collaborateable)
      add_breadcrumb("Invite User")
    end
  end
end
