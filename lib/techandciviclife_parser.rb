module Techandciviclife
  class Parser

    TOP_LEVEL_NODES = %w(
      Office
      Person
      Party
      Candidate
      CandidateContest
      CandidateSelection
      ElectoralDistrict
    )
=begin
    BallotMeasureContest - nope
    Office
    BallotMeasureSelection - nope
    Selection - what?
    RetentionContest - nope
  )
=end

    def reader
      Nokogiri::XML::Reader(File.open(Rails.root + 'lib/vip.xml'))
    end

    def run
      t = Time.now
      clean!
      unknown_node_names = Set.new
      reader.each do |node|
        if node.node_type != Nokogiri::XML::Reader::TYPE_END_ELEMENT
          if node.name.in?(TOP_LEVEL_NODES)
            Techandciviclife::Parsers.const_get(node.name).new(node).parse
          else
            unknown_node_names.add(node.name)
          end
        end
      end
      puts "skipped unknown nodes: #{unknown_node_names.inspect}"
      puts "finished in: #{Time.now - t} seconds"
    end

    def clean!
      ::Techandciviclife::Party.delete_all
      ::Techandciviclife::Person.delete_all
      ::Techandciviclife::Candidate.delete_all
      ::Techandciviclife::CandidateContest.delete_all
      ::Techandciviclife::CandidateSelection.delete_all
      ::Techandciviclife::ElectoralDistrict.delete_all
      ::Techandciviclife::Office.delete_all
    end
  end

  module Parsers

    class Base
      attr_reader :node, :xml, :id

      def initialize(node)
        @node = node
        @xml = Nokogiri::XML(node.outer_xml)
        @id = node.attribute('id')
      end
    end

    class Party < Base
      def parse
        name = xml.xpath("//Party/Name/Text[@language='en']").text
        ::Techandciviclife::Party.create!(name: name, internal_id: id)
      end
    end

    #Maybe redundant... can we just use the Candidate name and ignore this?
    class Person < Base
      def parse
        name = xml.xpath("//Person/FullName/Text[@language='en']").text
        puts [id, name]
        ::Techandciviclife::Person.create!(name: name, internal_id: id)
      end
    end

    class Candidate < Base
      def parse
        person_id = xml.xpath("//Candidate/PersonId").text
        party_id = xml.xpath("//Candidate/PartyId").text
        name = xml.xpath("//Candidate/BallotName/Text[@language='en']").text
        puts [id, person_id, party_id, name]
        ::Techandciviclife::Candidate.create!(name: name, internal_id: id, party_id: party_id, person_id: person_id)
      end
    end

    class CandidateContest < Base
      def parse
        name = xml.xpath("//CandidateContest/Name").text
        candidate_selections = xml.xpath("//CandidateContest/BallotSelectionIds").
          text.to_s.split(' ')
        electoral_district_id  = xml.xpath("//CandidateContest/ElectoralDistrictId").text
        office_id = xml.xpath("//CandidateContest/OfficeIds").text
        ::Techandciviclife::CandidateContest.create!(
          name: name,
          internal_id: id,
          candidate_selections: candidate_selections,
          electoral_district_id: electoral_district_id,
          office_id: office_id
        )
      end
    end

    class CandidateSelection < Base
      def parse
        candidate_ids = xml.xpath("//CandidateSelection/CandidateIds").text.to_s.split(' ')
        ::Techandciviclife::CandidateSelection.create!(
          candidate_ids: candidate_ids,
          internal_id: id
        )
      end
    end

    class ElectoralDistrict < Base
      def parse
        name = xml.xpath("//ElectoralDistrict/Name").text
        type = xml.xpath("//ElectoralDistrict/Type").text
        ::Techandciviclife::ElectoralDistrict.create!(
          name: name,
          internal_id: id,
          type: type
        )
      end
    end

    class Office < Base
      def parse
        description = xml.xpath("//Office/Description/Text[@language='en']").text
        electoral_district_id = xml.xpath("//Office/ElectoralDistrictId").text
        name = xml.xpath("//Office/Name/Text[@language='en']").text
        ::Techandciviclife::Office.create!(
          description: description,
          internal_id: id,
          electoral_district_id: electoral_district_id,
          name: name
        )
      end
    end
  end
end
