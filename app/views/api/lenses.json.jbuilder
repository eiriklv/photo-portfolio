json.array!(@lenses) do |lens|
  json.extract! lens, :id, :name
end
