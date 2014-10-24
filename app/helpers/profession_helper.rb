module ProfessionHelper
  def options_for_profession_type
    User::PROFESSIONS.map do |type|
      [profession_type_to_text(type), type]
    end
  end

  def position_type_to_text(type)
    t("users.professions.#{type}")
  end
end
