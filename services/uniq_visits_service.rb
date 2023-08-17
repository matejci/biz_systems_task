# frozen_string_literal: true

module Services
  class UniqVisitsService
    def initialize(hash)
      @hash = hash
    end

    def call
      process if valid?
    end

    private

    def process
      uniq_res = {}

      @hash.keys.each do |k|
        uniq_res[k] = @hash[k].uniq.size
      end

      uniq_res
    end

    def valid?
      @hash.is_a?(Hash)
    end
  end
end
