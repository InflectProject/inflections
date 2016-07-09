helpers do 
  def list?(inflection)
    inflection.attributes[:type].eql? 'list'
  end
end