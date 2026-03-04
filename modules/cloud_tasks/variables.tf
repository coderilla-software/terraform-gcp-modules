variable "name" {
  description = "Name of the Cloud Tasks queue"
  type        = string
}

variable "region" {
  description = "Region for the Cloud Tasks queue"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "max_concurrent_dispatches" {
  description = "Maximum number of concurrent tasks that can be dispatched"
  type        = number
  default     = 5
}

variable "max_dispatches_per_second" {
  description = "Maximum number of tasks that can be dispatched per second"
  type        = number
  default     = 500
}

variable "max_attempts" {
  description = "Maximum number of attempts for a task"
  type        = number
  default     = 3
}

variable "max_retry_duration" {
  description = "Maximum retry duration"
  type        = string
  default     = "10s"
}

variable "min_backoff" {
  description = "Minimum backoff duration"
  type        = string
  default     = "1s"
}

variable "max_backoff" {
  description = "Maximum backoff duration"
  type        = string
  default     = "60s"
}

variable "max_doublings" {
  description = "Maximum number of doublings in the backoff period"
  type        = number
  default     = 3
}

variable "invoker_members" {
  description = "List of members that can invoke tasks in this queue"
  type        = list(string)
  default     = []
} 