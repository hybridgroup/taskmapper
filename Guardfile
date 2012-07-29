# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rspec, :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  
  watch(%r{^lib/(.+)\.rb$}) { "spec" }
  
  watch(%r{^spec/(.+)_helper\.rb$})  { "spec" }
end
