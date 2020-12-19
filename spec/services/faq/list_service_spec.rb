require_relative './../../spec_helper.rb'

describe FaqModule::ListService do
  context '#call' do
    context 'list command' do
      context 'Zero faqs in database' do
        it "Return don't find message" do
          service = FaqModule::ListService.new({}, 'list')
          response = service.call
          expect(response).to match('Nada encontrado')
        end
      end

      context 'Two faqs in database' do
        it 'Find questions and answer in response' do
          service = FaqModule::ListService.new({}, 'list')

          faq1 = create(:faq)
          faq2 = create(:faq)

          response = service.call

          expect(response).to match(faq1.question)
          expect(response).to match(faq1.answer)

          expect(response).to match(faq2.question)
          expect(response).to match(faq2.answer)
        end
      end
    end

    context 'search command' do
      context 'Empty query' do
        it "return don't find message" do
          service = FaqModule::ListService.new({ 'query': '' }, 'search')

          response = service.call
          expect(response).to match('Nada encontrado')
        end
      end

      context 'Valid query' do
        it 'find question and answer in response' do
          faq = create(:faq)

          service = FaqModule::ListService.new({ 'query': faq.question.split(' ').sample }, 'search')

          response = service.call

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end

    context 'search_by_hashtag command' do
      context 'Invalid hashtag' do
        it "return don't find message" do
          service = FaqModule::ListService.new({ 'query': '' }, 'search_by_hashtag')

          response = service.call
          expect(response).to match('Nada encontrado')
        end
      end

      context 'Valid hashtag' do
        it 'With valid hashtag, find question and answer in response' do
          faq = create(:faq)
          hashtag = create(:hashtag)
          create(:faq_hashtag, faq: faq, hashtag: hashtag)

          service = FaqModule::ListService.new({ 'query': hashtag.name }, 'search_by_hashtag')

          response = service.call

          expect(response).to match(faq.question)
          expect(response).to match(faq.answer)
        end
      end
    end
  end
end
