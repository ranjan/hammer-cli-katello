module HammerCLIKatello

  class LifecycleEnvironmentCommand < HammerCLI::AbstractCommand

    class ListCommand < HammerCLIKatello::ListCommand
      resource KatelloApi::Resources::Environment, :index

      output do
        field :id, "ID"
        field :name, "Name"
      end

      apipie_options
    end

    class InfoCommand < HammerCLIKatello::InfoCommand
      resource KatelloApi::Resources::Environment, :show

      identifiers :id

      output do
        field :id, "ID"
        field :name, "Name"
        field :label, "Label"
        field :description, "Description"
        from :organization do
          field :name, "Organization"
        end
        field :library, "Library"
        field :prior, "Prior Lifecycle Environment"
      end

      def request_params
        super.merge(method_options)
      end

      apipie_options
    end

    class CreateCommand < HammerCLIKatello::CreateCommand
      resource KatelloApi::Resources::Environment, :create
      success_message "Environment created"
      failure_message "Could not create environment"

      apipie_options
    end

    class UpdateCommand < HammerCLIKatello::UpdateCommand
      success_message "Environment updated"
      failure_message "Could not update environment"
      resource KatelloApi::Resources::Environment, :update

      identifiers :id

      def request_params
        super.merge(method_options)
      end

      apipie_options
    end

    class DeleteCommand < HammerCLIKatello::DeleteCommand
      success_message "Environment deleted"
      failure_message "Could not delete environment"
      resource KatelloApi::Resources::Environment, :destroy

      identifiers :id

      def request_params
        super.merge(method_options)
      end

      apipie_options
    end

    autoload_subcommands
  end

  cmd_name = "lifecycle-environment"
  cmd_desc = "manipulate lifecycle_environments on the server"
  cmd_cls  = HammerCLIKatello::LifecycleEnvironmentCommand
  HammerCLI::MainCommand.subcommand(cmd_name, cmd_desc, cmd_cls)
end