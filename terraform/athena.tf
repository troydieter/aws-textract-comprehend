resource "aws_athena_workgroup" "analyze" {
  name = "analyze-${random_id.rando.hex}"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.resultbucket.id}/athena_output/"
      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}

resource "aws_glue_catalog_table" "aws_glue_catalog_table" {
  name          = "glue${random_id.rando.hex}"
  database_name = aws_athena_database.analyze-db.id
  table_type    = "EXTERNAL_TABLE"
  parameters = {
    EXTERNAL = "TRUE"
  }

  storage_descriptor {
    location      = "s3://${aws_s3_bucket.resultbucket.id}/result/"

    ser_de_info {
      name                  = "gluestr${random_id.rando.hex}"
      serialization_library = "org.apache.hadoop.hive.serde2.OpenCSVSerde"

      parameters = {
        separatorChar = ","
        quoteChar = "\""
        escapeChar = "\\"
      }
    }

    columns {
      name = "idnumber"
      type = "string"
    }

    columns {
      name = "category"
      type = "string"
    }

    columns {
      name = "text"
      type = "string"
    }

  }


}

resource "aws_athena_database" "analyze-db" {
  name   = "analyzeathenadb${random_id.rando.hex}"
  bucket = aws_s3_bucket.resultbucket.id
}

resource "aws_athena_named_query" "analyze-query" {
  name      = "query-${random_id.rando.hex}"
  workgroup = aws_athena_workgroup.analyze.id
  database  = aws_athena_database.analyze-db.name
  query     = "SELECT * FROM ${aws_athena_database.analyze-db.name}.${aws_glue_catalog_table.aws_glue_catalog_table.name} where category='TEST_TREATMENT_PROCEDURE' and text like '%glucose%'"
}