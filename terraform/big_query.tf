
resource "google_bigquery_dataset" "default" {
  dataset_id                  = "foo_${var.branch}_${var.suffix}"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = var.gcp_region

  labels = {
    env = "default"
  }
}

resource "google_bigquery_table" "default" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bar"
  deletion_protection = false
  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF

}

# resource "google_bigquery_table" "sheet" {
#   dataset_id = google_bigquery_dataset.default.dataset_id
#   table_id   = "sheet"

#   external_data_configuration {
#     autodetect    = true
#     source_format = "GOOGLE_SHEETS"

#     google_sheets_options {
#       skip_leading_rows = 1
#     }

#     source_uris = [
#       "https://docs.google.com/spreadsheets/d/123456789012345",
#     ]
#   }
# }