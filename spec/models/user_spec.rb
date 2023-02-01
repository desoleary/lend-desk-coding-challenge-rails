# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe '.new' do
    it 'add redis entry' do
      user = User.new(key: 'desoleary@gmail.com', password: 'some-password')
      user.save

      actual = User.find('desoleary@gmail.com')
      expect(actual.attributes).to eql({ key: 'desoleary@gmail.com', password: 'some-password' })
    end
  end
end
