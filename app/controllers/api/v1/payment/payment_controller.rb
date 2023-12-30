module Api
  module V1
    module Payment
      class PaymentController < ApplicationController

        def initialize
          @status = ['aprovado','negado']
        end

       def create
        render json: { status: @status[0], message: 'Pagamento criado com sucesso', created_at: Time.now,data: params[:payment]}
       end


       def random
        random = rand(0..1)
        if random == 0
          render json: { status: @status[0], message: 'Transação aprovada', created_at: Time.now,data: params[:payment]}
        else
          render json: { status: @status[1], message: 'Transação negada', created_at: Time.now,data: params[:payment]}
        end
       end

       def denied
        render json: { status: @status[0], message: 'Transação negada', created_at: Time.now,data: params[:payment]}
       end

        def approved
          render json: { status: @status[1], message: 'Transação aprovada', created_at: Time.now,data: params[:payment]}
        end

        def deny_condition
          choice = params[:reason].to_i if params[:reason].match?(/\A\d+\z/)
          case choice
            when 3
              render json: { status: @status[1], message: 'Cartão inválido', created_at: Time.now,data: params[:payment]}
            when 5
              render json: { status: @status[1], message: 'Negado pelo banco emissor', created_at: Time.now,data: params[:payment]}
            when 13
              render json: { status: @status[1], message: 'Valor inválido', created_at: Time.now,data: params[:payment]}
            when 14
              render json: { status: @status[1], message: 'Cartão inválido', created_at: Time.now,data: params[:payment]}
            when 21
              render json: { status: @status[1], message: 'Cancelamento não permitido', created_at: Time.now,data: params[:payment]}
            when 31
              render json: { status: @status[1], message: 'Bandeira não aceita', created_at: Time.now,data: params[:payment]}
            when 39
                render json: { status: @status[1], message: 'O pagamento por cartão de débito não esta disponível', created_at: Time.now,data: params[:payment]}
            when 51
              render json: { status: @status[1], message: 'Saldo insuficiente', created_at: Time.now,data: params[:payment]}
            when 54
              render json: { status: @status[1], message: 'Cartão vencido', created_at: Time.now,data: params[:payment]}
            when 57
              render json: { status: @status[1], message: 'Cartão perdido ou roubado', created_at: Time.now,data: params[:payment]}
            when 58
              render json: { status: @status[1], message: 'Transação não permitida para o cartão', created_at: Time.now,data: params[:payment]}
            when 62
              render json: { status: @status[1], message: 'Cartão restrito para uso doméstico', created_at: Time.now,data: params[:payment]}
            when 94
              render json: { status: @status[1], message: 'Transação duplicada', created_at: Time.now,data: params[:payment]}
            when 96
              render json: { status: @status[1], message: 'Erro no sistema', created_at: Time.now,data: params[:payment]}
            when 99
              render json: { status: @status[1], message: 'Tempo de resposta excedido', created_at: Time.now,data: params[:payment]}
            when 77
              render json: { status: @status[1], message: 'Cartão cancelado', created_at: Time.now,data: params[:payment]}
            when 78
              render json: { status: @status[1], message: 'Cartão bloqueado', created_at: Time.now,data: params[:payment]}
            when 80
              render json: { status: @status[1], message: 'Transação não autorizada', created_at: Time.now,data: params[:payment]}
            when 82
              render json: { status: @status[1], message: 'CVV inválido', created_at: Time.now,data: params[:payment]}
            when 83
              render json: { status: @status[1], message: 'Cartão bloqueado', created_at: Time.now,data: params[:payment]}
            else
              render json: {error: "código de operação inválido"}
          end
        end

        def simulate
          required = [:amount,:card_number,:card_holder_name,:card_expiration_date,:card_cvv,:payment_method,:installments, :card_flag]

          if required.all? {|k| params[:payment].key? k}


            render json: {
              status: @status[0], message: 'Transação aprovada',
              amount: params[:payment][:amount],
              card_holder_name: params[:payment][:card_holder_name],
              payment_method: params[:payment][:payment_method],
              installments: if params[:payment][:installments] > 1 then "#{params[:payment][:installments]} x #{(params[:payment][:amount] / 4)}" else "1" end,
              card_flag: params[:payment][:card_flag],
              created_at: Time.now
            }
          else
            render json: {error: "Transação não efetuada, dados incompletos"}
          end

        end


      end
    end
  end
end
