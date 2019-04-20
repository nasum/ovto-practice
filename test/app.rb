require 'ovto'

class MyApp < Ovto::App
  class State < Ovto::State
    item :todo, default: ''
    item :list, default: []
  end

  class Actions < Ovto::Actions
    def change_input(value:)
      { todo: value }
    end

    def add_todo(value:)
      state.list.push(value)
      { list: state.list, todo: '' }
    end
  end

  class MainComponent < Ovto::Component
    def render
      o 'div' do
        o 'div' do
          o 'input',
            type: 'text',
            onchange: ->(e) { actions.change_input(value: e.target.value) },
            value: state.todo
          o 'button', {
            onclick: ->(_e) { actions.add_todo(value: state.todo) }
          }, '追加'
        end
        o 'div' do
          o 'ul' do
            state.list.each do |item|
              o 'li', item
            end
          end
        end
      end
    end
  end
end

MyApp.run(id: 'ovto')
