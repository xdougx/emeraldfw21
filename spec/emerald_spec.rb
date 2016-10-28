describe EmeraldFW  do 

  context 'Attributes' do

    it 'has a version number' do
      expect(EmeraldFW::VERSION).not_to be nil
    end

  end

  context 'Submodules' do 

  	it 'has a EmeraldFW::Entities submodule' do 
  	  expect(EmeraldFW::Entities).not_to be nil
  	end

  end

end