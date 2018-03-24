# frozen_string_literal: true

Aws.config[:access_key_id] = ENV['S3_KEY']
Aws.config[:secret_access_key] = ENV['S3_SECRET']
