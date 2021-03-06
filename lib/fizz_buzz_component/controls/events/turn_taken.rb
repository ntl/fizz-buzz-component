module FizzBuzzComponent
  module Controls
    module Events
      module TurnTaken
        def self.example(game_id: nil, counter: nil, answer: nil, time: nil, processed_time: nil, previous_message: nil, position: nil, global_position: nil)
          game_id ||= Game.id
          counter ||= self.counter
          answer ||= self.answer
          time ||= Time::Effective.example
          processed_time ||= Time::Processed.example

          previous_message ||= Message.example

          position ||= Position.example
          global_position ||= Position::Global.example

          stream_name = StreamName::FizzBuzz.example(game_id: game_id)

          turn_taken = Messages::Events::TurnTaken.new

          turn_taken.game_id = game_id
          turn_taken.answer = answer
          turn_taken.counter = counter
          turn_taken.time = time
          turn_taken.processed_time = processed_time

          turn_taken.metadata.stream_name = stream_name
          turn_taken.metadata.position = position
          turn_taken.metadata.global_position = global_position

          unless previous_message.nil?
            turn_taken.metadata.follow(previous_message.metadata)
          end

          turn_taken
        end

        def self.answer
          Answer.example
        end

        def self.counter
          Answer.counter
        end

        module Initial
          def self.example
            TurnTaken.example(counter: counter, answer: answer, position: position)
          end

          def self.position
            0
          end

          def self.answer
            Answer::Initial.example
          end

          def self.counter
            Answer::Initial.counter
          end
        end

        module Final
          def self.example
            TurnTaken.example(counter: counter, answer: answer)
          end

          def self.answer
            Answer::Final.example
          end

          def self.counter
            Answer::Final.counter
          end
        end
      end
    end
  end
end
