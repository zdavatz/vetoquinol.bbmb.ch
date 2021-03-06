#!/usr/bin/env ruby
# encoding: utf-8
# Util::TestUpdater -- bbmb.ch -- 14.09.2006 -- hwyss@ywesee.com

$: << File.expand_path('..', File.dirname(__FILE__))
$: << File.expand_path('../../lib', File.dirname(__FILE__))

require 'bbmb/util/csv_importer'
require 'stub/persistence'
require 'flexmock/minitest'
require 'minitest/autorun'
require 'pp'

module BBMB
  module Util
    class TestCustomerImporter < ::Minitest::Test
      def setup
        Model::Customer.clear_instances
        BBMB.server = flexmock('server')
        BBMB.server.should_ignore_missing
      end
      def test_import
        zurich = "Zürich"
        filename = File.expand_path(File.join(File.dirname(__FILE__), '..', 'data', 'kunden.csv'))
        src = File.read(filename, :encoding => 'iso-8859-1')
        persistence = flexmock("persistence")
        found_zurich = false
        persistence.should_receive(:save).times(10).and_return do |customer|
          assert_instance_of(Model::Customer, customer)
          found_zurich = true if zurich.eql?(customer.city)
        end
        nr_customers = CustomerImporter.new.import(src, persistence)
        assert_equal(10, nr_customers)
        assert_equal(true, found_zurich)
      end
      def test_import_record
        line = <<-EOS
15047;1061;;VETOQU;Herr Dr.med.vet.;Aeberhard Ueli;Gemeindehausplatz 4;rue strasse;address3;;5323;BERNE;business;mobile;private;fax;email
        EOS
        importer = CustomerImporter.new
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |customer|
          assert_instance_of(Model::Customer, customer)
          assert_equal("15047", customer.customer_id)
          assert_equal("Herr Dr.med.vet.", customer.drtitle)
          assert_equal("Aeberhard Ueli", customer.organisation)
          assert_equal("Gemeindehausplatz 4", customer.address1)
          assert_equal("rue strasse", customer.address2)
          assert_equal("address3", customer.address3)
          assert_equal("5323", customer.plz)
          assert_equal("BERNE", customer.city)
          assert_equal("business", customer.phone_business)
          assert_equal("private", customer.phone_private)
          assert_equal("mobile", customer.phone_mobile)
          assert_equal("fax", customer.fax)
          assert_equal("email", customer.email)
        }
        importer.import(line, persistence)
      end
      def test_import_record__protected_data
        line = <<-EOS
15047;1061;;VETOQU;Herr Dr.med.vet.;Aeberhard Ueli;Gemeindehausplatz 4;rue strasse;address3;;5323;BERNE;business;mobile;private;fax;email
        EOS
        customer = Model::Customer.new("15047")
        customer.address2 = 'corrected line'
        customer.protect!(:address2)
        importer = CustomerImporter.new
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |customer|
          assert_instance_of(Model::Customer, customer)
          assert_equal("15047", customer.customer_id)
          assert_equal("Herr Dr.med.vet.", customer.drtitle)
          assert_equal("Aeberhard Ueli", customer.organisation)
          assert_equal("Gemeindehausplatz 4", customer.address1)
          assert_equal("corrected line", customer.address2)
          assert_equal("address3", customer.address3)
          assert_equal("5323", customer.plz)
          assert_equal("BERNE", customer.city)
          assert_equal("business", customer.phone_business)
          assert_equal("private", customer.phone_private)
          assert_equal("mobile", customer.phone_mobile)
          assert_equal("fax", customer.fax)
          assert_equal("email", customer.email)
        }
        importer.import(line, persistence)
      end
    end
    class TestProductImporter < ::Minitest::Test
      def setup
        Model::Product.clear_instances
      end
      def test_import
        src = <<-EOS
gesperrt;0101387;0340096716076;Lacrybiotic pom opht 10g;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;yes
gesperrt;0101904;0340096849529;Neomycine hydroc pom 10g;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;yes
geaendert;0104203;;Marbocyl 5mg cpr bt100;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
gesperrt;0104313;0340096760657;Marbocyl 10% sol 100ml;;25.5000;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;yes
gesperrt;0300212;;Arthri dog cpr bt40 ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
gesperrt;0300619;;Calmivet cpr bt40 ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
geaendert;0301862;;Energidex sol inj 500ml ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
gesperrt;0302467;;Hydrocortiderm 60g ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
gesperrt;0303292;;Megecat cpr bt18 ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
gesperrt;0303688;;Oribiotic pom 10g ch;;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
        EOS
        persistence = flexmock("persistence")
        persistence.should_receive(:save).times(2).with(Model::Product)
        persistence.should_receive(:all)
        ProductImporter.new.import(src, persistence)
      end
      def test_import_record
        line = <<-EOS
gesperrt;0313720;;Marbocyl 10% sol 50ml ch;;8.6500;;;;;;;;;3;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
        EOS
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |product|
          assert_instance_of(Model::Product, product)
          assert_equal("0313720", product.article_number)
          assert_equal("gesperrt", product.status)
          assert_nil(product.ean13)
          assert_equal("Marbocyl 10% sol 50ml ch", product.description.de)
          assert_equal(3, product.vat)
          assert_nil(product.pcode)
          assert_equal(0, product.l1_qty)
          assert_equal(nil, product.l1_price)
          assert_equal(0, product.l2_qty)
          assert_equal(nil, product.l2_price)
          assert_equal(0, product.l3_qty)
          assert_equal(nil, product.l3_price)
          assert_equal(0, product.l4_qty)
          assert_equal(nil, product.l4_price)
          assert_equal(0, product.l5_qty)
          assert_equal(nil, product.l5_price)
          assert_equal(0, product.l6_qty)
          assert_equal(nil, product.l6_price)
        }
        persistence.should_receive(:all)
        ProductImporter.new.import(line, persistence)
      end
      def test_import_record__ean
        line = <<-EOS
gesperrt;0801031;0340117772763;Equi biotin forte 1 kg;;0;;;;;;;;;3;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
        EOS
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |product|
          assert_instance_of(Model::Product, product)
          assert_equal("0801031", product.article_number)
          assert_equal("gesperrt", product.status)
          assert_equal("0340117772763", product.ean13)
          assert_equal("Equi biotin forte 1 kg", product.description.de)
        }
        persistence.should_receive(:all)
        ProductImporter.new.import(line, persistence)
      end
      def test_import_record__quotes
        line = <<-EOS
gesperrt;402750;;Info-Katalog Eq "nor";;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
        EOS
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |product|
          assert_instance_of(Model::Product, product)
          assert_equal("402750", product.article_number)
          assert_equal("gesperrt", product.status)
          assert_equal("Info-Katalog Eq \"nor\"", product.description.de)
        }
        persistence.should_receive(:all)
        ProductImporter.new.import(line, persistence)
      end
      def test_import_record__postprocess
        line = <<-EOS
gesperrt;402750;;Info-Katalog Eq "nor";;0;;;;;;;;;Y;;;;;;;;;;;VETOQU;112;;0;0;0;0;0;0;0;0;0;0;0;0;;no
        EOS
        persistence = flexmock("persistence")
        persistence.should_receive(:save).and_return { |product|
          assert_instance_of(Model::Product, product)
          assert_equal("402750", product.article_number)
          assert_equal("gesperrt", product.status)
          assert_equal("Info-Katalog Eq \"nor\"", product.description.de)
        }
        delete_me = Model::Product.new('1234')
        persistence.should_receive(:all).and_return { |klass, block|
          assert_equal(Model::Product, klass)
          block.call(delete_me) 
        }
        persistence.should_receive(:delete).with(delete_me)
        ProductImporter.new.import(line, persistence)
      end
    end
  end
end
