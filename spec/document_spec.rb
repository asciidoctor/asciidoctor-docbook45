require_relative 'spec_helper'

describe 'Asciidoctor::DocBook45::Converter - Document' do
  context 'article' do
    it 'should use doctype declaration' do
      output = to_docbook45 <<~'EOS'
      = Document Title
      EOS
      (expect output).to include '<!DOCTYPE article'
      (expect output).to include '<article '
      (expect output).not_to include ' xmlns="http://docbook.org/ns/docbook"'
    end

    it 'should include xmlns if xmlns attribute is set' do
      output = to_docbook45 <<~'EOS'
      = Document Title
      :xmlns:
      EOS
      (expect output).to include ' xmlns="http://docbook.org/ns/docbook"'
    end

    it 'should prefix info tag' do
      output = to_docbook45 <<~'EOS'
      = Document Title
      Author Name
      EOS
      (expect output).to include '<articleinfo>'
    end
  end

  context 'book' do
    it 'should use doctype declaration' do
      output = to_docbook45 <<~'EOS', doctype: 'book'
      = Document Title
      EOS
      (expect output).to include '<!DOCTYPE book'
      (expect output).to include '<book '
      (expect output).not_to include ' xmlns="http://docbook.org/ns/docbook"'
    end

    it 'should include xmlns if xmlns attribute is set' do
      output = to_docbook45 <<~'EOS', doctype: 'book'
      = Document Title
      :xmlns:
      EOS
      (expect output).to include ' xmlns="http://docbook.org/ns/docbook"'
    end

    it 'should prefix info tag' do
      output = to_docbook45 <<~'EOS', doctype: 'book'
      = Document Title
      Author Name
      EOS
      (expect output).to include '<bookinfo>'
    end
  end
end
