class String
  def replace_rare_chars
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end
end