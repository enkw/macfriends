module Aws
  module ClientWaiters

    # @api private
    def self.included(subclass)
      class << subclass

        def set_waiters(waiters)
          @waiters =
            case waiters
            when Waiters::Provider then waiters
            when Hash then Waiters::Provider.new(waiters)
            when String then Waiters::Provider.new(Aws.load_json(waiters))
            when nil then Waiters::NullProvider.new
            else raise ArgumentError, 'invalid waiters'
            end
        end

        def waiters
          @waiters
        end

      end
    end

    # Waits until a particular condition is satisfied. This works by
    # polling a client request and checking for particular response
    # data or errors. Waiters each have a default duration max attempts
    # which are configurable.  Additionally, you can register callbacks
    # and stop waiters by throwing `:success` or `:failure`.
    #
    # @example Basic usage
    #   client.wait_until(:waiter_name)
    #
    # @example Configuring interval and maximum attempts
    #   client.wait_until(:waiter_name) do |w|
    #     w.interval = 10    # number of seconds to sleep between attempts
    #     w.max_attempts = 6 # maximum number of polling attempts
    #   end
    #
    # @example Rescuing a failed wait
    #   begin
    #     client.wait_until(:waiter_name)
    #   rescue Aws::Waiters::Errors::WaiterFailed
    #     # gave up waiting
    #   end
    #
    # @example Waiting with progress callbacks
    #   client.wait_until(:waiter_name) do |w|
    #
    #     # yields just before polling for change
    #     w.before_attempt do |attempt|
    #       # attempts - number of previous attempts made
    #     end
    #
    #     # yields before sleeping
    #     w.before_wait do |attempt, prev_response|
    #       # attempts - number of previous attempts made
    #       # prev_response - the last client response received
    #     end
    #   end
    #
    # @example Throw :success or :failure to terminate early
    #   # wait for an hour, not for a number of requests
    #   client.wait_until(:waiter_name) do |waiter|
    #     one_hour = Time.now + 3600
    #     waiter.max_attempts = nil
    #     waiter.before_attempt do |attempt|
    #       throw(:failure, 'waited to long') if Time.now > one_hour
    #     end
    #   end
    #
    # @param [Symbol] waiter_name The name of the waiter. See {#waiter_names}
    #   for a full list of supported waiters.
    # @param [Hash] params Additional request parameters. See the {#waiter_names}
    #   for a list of supported waiters and what request they call. The
    #   called request determines the list of accepted parameters.
    # @return [Seahorse::Client::Response] Returns the client response from
    #   the successful polling request. If `:success` is thrown from a callback,
    #   then the 2nd argument to `#throw` is returned.
    # @yieldparam [Waiters::Waiter] waiter Yields a {Waiters::Waiter Waiter} 
    #   object that can be configured prior to waiting.
    # @raise [Waiters::Errors::NoSuchWaiter] Raised when the named waiter
    #   is not defined.
    # @raise [Waiters::Errors::WaiterFailed] Raised when one of the
    #   following conditions is met:
    #
    #   * A failure condition is detected
    #   * The maximum number of attempts has been made without success
    #   * `:failure` is thrown from a callback
    #
    def wait_until(waiter_name, params = {}, &block)
      waiter = self.class.waiters.waiter(waiter_name)
      yield(waiter) if block_given?
      waiter.wait(self, params)
    end

    # Returns the list of supported waiters.
    # @return [Array<Symbol>]
    def waiter_names
      self.class.waiters.waiter_names
    end

  end
end
