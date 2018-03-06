module Techandciviclife
  class Parser

    TOP_LEVEL_NODES = %w(
    Party
    )
=begin
    Person
    Candidate
    BallotMeasureContest
    ElectoralDistrict
    Office
    CandidateSelection
    CandidateContest
    Party
    BallotMeasureSelection
    Selection
    RetentionContest
  )
=end

    def reader
      Nokogiri::XML::Reader(File.open(Rails.root + 'lib/vip.xml'))
    end

    def run
      t = Time.now
      unknown_node_names = Set.new
      reader.each do |node|
        if node.node_type != Nokogiri::XML::Reader::TYPE_END_ELEMENT
          if node.name.in?(TOP_LEVEL_NODES)
            Techandciviclife::Parsers.const_get(node.name).new.parse(node)
          else
            unknown_node_names.add(node.name)
          end
        end
      end
      puts "skipped unknown nodes: #{unknown_node_names.inspect}"
      puts "finished in: #{Time.now - t} seconds"
    end
  end

  module Parsers
    class Party
      def parse(node)
        id = node.attribute('id')
        name = Nokogiri::XML(node.outer_xml).xpath("//Party/Name/Text[@language='en']").text
        puts [id, name]
      end
    end
  end
end
