require_relative './../../spec_helper.rb'

describe FaqModule::CreateService do
  before do
    @question = Faker::Lorem.sentence
    @answer = Faker::Lorem.sentence
    @hashtags = "#{Faker::Lorem.word}, #{Faker::Lorem.word}"
  end

  describe '#call' do
    context 'without hashtag params' do
      it 'will receive a error' do
        service = FaqModule::CreateService.new({ 'question': @question, 'answer': @answer })
        response = service.call
        expect(response).to match('Hashtag Obrigatória')
      end
    end

    context 'with valid params' do
      before do
        service = FaqModule::CreateService.new({ 'question': @question, 'answer': @answer, 'hashtags': @hashtags })
        @response = service.call
      end

      it 'receive success message' do
        expect(@response).to match('Criado com sucesso')
      end

      it 'question and answer is present in database' do
        expect(Faq.last.question).to match(@question)
        expect(Faq.last.answer).to match(@answer)
      end

      it 'hashtags are created' do
        expect(@hashtags.split(/[\s,]+/).first).to match(Hashtag.first.name)
        expect(@hashtags.split(/[\s,]+/).last).to match(Hashtag.last.name)
      end
    end
  end
end
