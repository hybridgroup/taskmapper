# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rspec, :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  
  watch(%r{^lib/(.+)\.rb$}) do |m|
    spec_path = "spec/#{m[1]}_spec.rb"
    File.exists?(spec_path) ? spec_path : "spec"
  end
  
  watch(%r{^spec/(.+)_helper\.rb$})  { "spec" }
end
