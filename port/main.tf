resource "port_action" "create_config_controller" {
  title       = "Create Config Controller"
  identifier  = "create_config_controller"
  description = "Create a GKE Config Controller instance"
  icon        = "GKE"
  self_service_trigger = {
    operation        = "CREATE"
    order_properties = ["name", "location", "instance_type", "root_sync_repo", "root_sync_ref", "root_sync_dir"]
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
          default     = "europe-west1"
          enum        = ["europe-west1", "us-central1"]
        }
        instance_type = {
          title       = "Instance Type"
          required    = true
          description = "Type of GKE Config Controller instance"
          default     = "Autopilot"
          enum        = ["Autopilot", "Standard"]
        }
        root_sync_repo = {
          title       = "Config Sync repo"
          required    = true
          description = "Repository to sync using Config Sync"
          default     = "https://github.com/paulwilljones/gke-enterprise-self-service"
        }
        root_sync_ref = {
          title       = "Config Sync repo ref"
          required    = true
          description = "Git ref of repository to sync using Config Sync"
          default     = "main"
        }
        root_sync_dir = {
          title       = "Config Sync repo directory"
          required    = true
          description = "Directory of repository to sync using Config Sync"
          default     = "user-clusters"
        }
      }
    }
  }
  github_method = {
    org      = "paulwilljones"
    repo     = "gke-enterprise-self-service"
    workflow = "create-config-controller-paulwilljones.yaml"
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

resource "port_action" "create_gke" {
  title       = "Create GKE cluster"
  identifier  = "create_gke_cluster"
  description = "Create a GKE cluster"
  icon        = "GKE"
  self_service_trigger = {
    operation        = "CREATE"
    order_properties = ["name", "location"]
    user_properties = {
      string_props = {
        name = {
          title       = "Name"
          required    = true
          description = "Name of GKE cluster"
          min_length  = 8
          max_length  = 63
        }
        location = {
          title       = "Location"
          required    = true
          description = "Location of Config Controller"
          default     = "europe-west1"
          enum        = ["europe-west1", "us-central1"]
        }
        instance_type = {
          title       = "Instance Type"
          required    = true
          description = "Type of GKE cluster"
          default     = "Autopilot"
          enum        = ["Autopilot", "Standard"]
        }
      }
    }
  }
  github_method = {
    org      = "paulwilljones"
    repo     = "gke-enterprise-self-service"
    workflow = "create-gke.yaml"
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
