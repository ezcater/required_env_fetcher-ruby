# frozen_string_literal: true

require "required_env_fetcher/version"

module RequiredEnvFetcher
  def self.fetch(key, default = nil)
    if ENV["SKIP_REQUIRED_ENV_VAR_ENFORCEMENT"] == "true"
      ENV.fetch(key, default || "")
    else
      ENV.fetch(key)
    end
  end
end
