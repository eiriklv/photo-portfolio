Paperclip.interpolates :maybe_public do |attachment, style|
  style == :original ? 'private' : 'public'
end