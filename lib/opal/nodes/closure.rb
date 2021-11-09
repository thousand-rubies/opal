module Opal
  module Nodes
    # This module takes care of providing information about the
    # closure stack that we have for the nodes during compile time.
    # This is not a typical node.
    #
    # Also, while loops are not closures per se, this module also
    # takes a note about them.
    #
    # Then we can use this information for control flow like
    # generating breaks, nexts, returns.
    class Closure
      FUNCTION = 1
      DEF = 2
      ITER = 4
      MODULE = 8
      LOOP = 16

      ANY = FUNCTION | DEF | ITER | MODULE | LOOP

      def initialize(node, type, parent)
        @node, @type, @parent = node, type, parent
        @catchers = []
      end

      def register_catcher(type=:return)
        @catchers << type
      end

      attr_accessor :node, :type

      module NodeSupport
        def push_closure(type=FUNCTION)
          closure = Closure.new(self, type, select_closure)
          @compiler.closure_stack << closure
          @closure = closure
        end

        attr_accessor :closure

        def pop_closure
          @compiler.closure_stack.pop
        end

        def in_closure(type=FUNCTION)
          closure = push_closure(type)
          out = yield closure
          pop_closure
          out
        end

        def select_closure(type=ANY)
          @compiler.closure_stack.reverse.find do |i|
            (i.type & type) != 0
          end
        end

        def thrower(type=:return)
          case type
          when :return
            # Find the closest DEF = x
            # if == closest FUNCTION (lambda must be set as a function and iter)
            #   "return"
            # else
            #   "Opal.cflow(:return_x, val)" (set x to catch it and return)
            # end
          when :next
            # Find the closest ITER|LOOP
            # if LOOP
            #   "continue"
            # elsif ITER = x
            #   if == closest FUNCTION
            #     "return"
            #   else
            #     "Opal.cflow(:next_x, val)" (set x to catch it and return)
            #   end
            # end
          when :break
            # Find the closest ITER|LOOP
            # if LOOP
            #   "break" (set retval)
            # elsif ITER
            #   "Opal.cflow(:break_x, val)"
            # end
          when :redo
            # Find the closest ITER|LOOP
            # if LOOP
            #   "break" (set retval; set redoer?)
            # elsif ITER
            #   "Opal.cflow(:break_x, val)"
            # end
          when :retry
            # Find the closest RETRIER and Opal.cflow(:retry) (set x to catch it)
          end
        end

        # Generate a catcher if thrower has been used
        def catcher
        end
      end

      module CompilerSupport
        def closure_stack
          @closure_stack ||= []
        end
      end
    end
  end
end