class UserAuthOrganizer < ApplicationOrganizer
  def self.steps
    [ValidatorAction, UserAuthAction]
  end

  class ValidatorAction < ApplicationValidatorAction
    self.contract_class = UserAuthContract
  end
end
