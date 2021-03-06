# frozen_string_literal: true

require_relative 'base_logic'

class Logic
  class Bird < BaseLogic
    attr_reader :acceleration, :speed

    def initialize(game:)
      super(game: game, width: 34, height: 24)
      reset!
    end

    def reset!
      @x = 106
      @y = 243
      @speed = 0
      @flight = 0
      @acceleration = 0
    end

    def fly!
      @acceleration = -3.5
      @speed = 0
    end

    def move!
      started? ? apply_gravity! : float!
      self.y += @speed
    end

    private

    # Ensure decelerating the bird flight with gravity.
    # If resulting acceleration get to the gravity level
    # ensure not to overflow it.
    def apply_gravity!
      @acceleration += gravity if @acceleration < gravity
      @speed += @acceleration
    end

    def float!
      @init_y ||= self.y
      @speed = 0.4 if @speed.zero?
      @speed *= -1 if (self.y - @init_y).abs >= 5
    end
  end
end
