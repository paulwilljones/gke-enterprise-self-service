resource "port_action" "create_microservice" {
  title       = "Create Config Controller TF"
  identifier  = "create_config_controller_tf"
  description = "Create a GKE Config Controller instance"
  icon        = "GKE"
  self_service_trigger = {
    operation        = "CREATE"
    order_properties = ["name", "location"]
    user_properties = {
      string_props = {
        name = {
          title       = "Name"
          required    = true
          description = "Name of GKE Config Controller Instance"
          min_length  = 8
          max_length  = 63
        }
        location = {
          title       = "Location"
          required    = true
          description = "Location of Config Controller"
          default     = "europe-west2"
          enum        = ["europe-west2", "us-central1"]
        }
        instance_type = {
          title       = "Instance Type"
          required    = true
          description = "Type of GKE Config Controller instance"
          default     = "Autopilot"
          enum        = ["Autopilot", "Standard"]
        }
      }
    }
  }
  github_method = {
    org      = "jetstack"
    repo     = "gke-enterprise-self-service"
    workflow = "deploy.yaml"
    workflow_inputs = jsonencode({
      "{{ spreadValue() }}" : "{{ .inputs }}",
      "port_context" : {
        "runId" : "{{ .run.id }}",
      }
    })
    report_workflow_status = true
  }
  required_approval = false
}
