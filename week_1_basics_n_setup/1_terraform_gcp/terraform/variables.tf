locals {
  data_lake_bucket = "dtc_data_lake"
}

variable "project" {
  description = "Project name"
  default     = "de-zoomcamp-411820"
}

variable "region" {
  description = "Region for GCP resources. Choose as per your location: https://cloud.google.com/about/locations"
  default     = "us-west1"
  type        = string
}

variable "credentials" {
  description = "Service account credentials"
  default     = "./keys/de-zoomcamp-411820-54d684e928d0.json"
}

variable "storage_class" {
  description = "Storage class type for your bucket. Check official docs for more info."
  default     = "STANDARD"
}

variable "BQ_DATASET" {
  description = "BigQuery Dataset that raw data (from GCS) will be written to"
  type        = string
  default     = "trips_data_all"
}
