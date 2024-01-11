provider "google" {
   credentials = "${file("../creds/serviceaccount.json")}"
   project     = "animated-bay-224723" # REPLACE WITH YOUR PROJECT ID
   region      = "australia-southeast1"
 }