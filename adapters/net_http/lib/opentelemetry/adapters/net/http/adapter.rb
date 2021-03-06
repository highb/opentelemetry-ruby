# frozen_string_literal: true

# Copyright 2020 OpenTelemetry Authors
#
# SPDX-License-Identifier: Apache-2.0

module OpenTelemetry
  module Adapters
    module Net
      module HTTP
        # The Adapter class contains logic to detect and install the Net::HTTP
        # instrumentation adapter
        class Adapter < OpenTelemetry::Instrumentation::Adapter
          install do |_config|
            require_dependencies
            patch
          end

          present do
            defined?(::Net::HTTP)
          end

          private

          def require_dependencies
            require_relative 'patches/instrumentation'
          end

          def patch
            ::Net::HTTP.prepend(Patches::Instrumentation)
          end
        end
      end
    end
  end
end
