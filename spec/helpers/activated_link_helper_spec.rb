require 'spec_helper'

describe ActivatedLinkHelper do
  describe '#activated_link_to' do
    it 'should pass options' do
      mock(helper).link_to "Blah", "blah", {:class => ["inactive"]}
      helper.activated_link_to "Blah", "blah"
    end

    it 'should capture blocks' do
      mock(helper).link_to "Blah", "blah", {:class => ["inactive"]}
      helper.activated_link_to("blah") { "Blah" }
    end

    it 'should activate by path' do
      {"foo" => false, "blah?thing" => true, "blah" => true, "blah/" => true, "blah/thing" => true}.each do |url, active|
        stub(helper.request).fullpath { url }
        mock(helper).link_to "Blah", "blah", {:class => ["#{"in" unless active}active"]}
        helper.activated_link_to("blah") { "Blah" }
      end
    end

    it 'should activate by exact path' do
      {"foo" => false, "blah?thing" => true, "blah" => true, "blah/" => true, "blah/thing" => false}.each do |url, active|
        stub(helper.request).fullpath { url }
        mock(helper).link_to "Blah", "blah", {:class => ["#{"in" unless active}active"]}
        helper.activated_link_to("blah", :exact => true) { "Blah" }
      end
    end

    it 'should activate by an array of subpaths' do
      {"foo" => false, "blah?thing" => true, "blah" => true, "blah/" => true, "blah/thing" => true, "blah/other" => false}.each do |url, active|
        stub(helper.request).fullpath { url }
        mock(helper).link_to "Blah", "blah", {:class => ["#{"in" unless active}active"]}
        helper.activated_link_to("blah", :only_paths => ["thing"]) { "Blah" }
      end
    end

    it 'should activate by a subpath regular expression' do
      {"foo" => false, "blah?thing" => true, "blah" => true, "blah/" => true, "blah/this" => true, "blah/thing" => true, "blah/other" => false}.each do |url, active|
        stub(helper.request).fullpath { url }
        mock(helper).link_to "Blah", "blah", {:class => ["#{"in" unless active}active"]}
        helper.activated_link_to("blah", :only_paths => /\Athi/) { "Blah" }
      end
    end

    it 'should activate by a subpath' do
      {"foo" => false, "blah?thing" => true, "blah" => true, "blah/" => true, "blah/thing" => true, "blah/other" => false}.each do |url, active|
        stub(helper.request).fullpath { url }
        mock(helper).link_to "Blah", "blah", {:class => ["#{"in" unless active}active"]}
        helper.activated_link_to("blah", :only_paths => "thing") { "Blah" }
      end
    end
  end
end
