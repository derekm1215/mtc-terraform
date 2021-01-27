# ---- pcmd database/outputs.tf -----

output "db_endpoint" {
  value = aws_db_instance.plantcmd_db.endpoint
}

output "pcmd_db" {
  value = aws_db_instance.plantcmd_db
}
