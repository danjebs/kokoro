class InvitationsController < DashboardController
  before_action :set_invitation, only: %i[show edit update destroy]
  before_action :initialize_invitation, only: %i[new create]
  before_action :set_breadcrumbs, only: %i[index new]

  def index
    @invitations = policy_scope(Invitation)
      .where(invitee: current_user)
      .order(status: :asc, created_at: :desc)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @invitation.save
      InvitationMailer.invitation_email(@invitation).deliver_later

      redirect_to @invitation.collaborateable, notice: "Invitation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    update_params = invitation_params.deep_dup()

    if current_user.email == @invitation.email
      update_params[:invitee_id] = current_user.id

      if @invitation.status_is_pending? && invitation_params[:status] == "accepted"
        collaborator = @invitation.collaborateable.collaborators.create!(user: current_user)
        update_params[:collaborator_id] = collaborator.id
      end
    end

    if @invitation.update(update_params)
      redirect_target = @invitation.status_is_accepted? ? @invitation.collaborateable : invitations_url
      redirect_to redirect_target, notice: "Invitation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    collaborateable = @invitation.collaborateable

    @invitation.destroy!

    redirect_to collaborateable, status: :see_other, notice: "Invitation was successfully destroyed."
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
