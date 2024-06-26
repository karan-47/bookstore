describe TransactionsController, type: :controller do
  describe "GET #index" do
    context "when user is logged in" do
      before(:each) do
        user = create(:user)
        sign_in user
        get :index
      end

      it "renders the :index template" do
        expect(response).to render_template(:index)
      end

      it "assigns @transactions to the user's transactions" do
        expect(assigns(:transactions)).to eq(subject.current_user.transactions)
      end
    end

    context "when user is not logged in" do
      before(:each) do
        get :index
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      before(:each) do
        user = create(:user)
        sign_in user
        transaction = create(:transaction, user: user)
        get :show, params: { id: transaction.id }
      end

      it "renders the :show template" do
        expect(response).to render_template(:show)
      end

      it "assigns @transaction to the specified transaction" do
        expect(assigns(:transaction)).to eq(Transaction.find_by_id(subject.params[:id]))
      end
    end

    context "when user is not logged in" do
      before(:each) do
        transaction = create(:transaction)
        get :show, params: { id: transaction.id }
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #new" do
    context "when user is logged in" do
      before(:each) do
        user = create(:user)
        sign_in user
        get :new, params: { book_id: create(:book).id }
      end

      it "renders the :new template" do
        expect(response).to render_template(:new)
      end

      it "assigns @transaction to a new Transaction object" do
        expect(assigns(:transaction)).to be_a_new(Transaction)
      end
    end

    context "when user is not logged in" do
      before(:each) do
        get :new, params: { book_id: create(:book).id }
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    context "when user is logged in" do
      before(:each) do
        user = create(:user)
        sign_in user
        @book = create(:book)
        @transaction_attributes = attributes_for(:transaction, book_id: @book.id)
      end

      it "creates a new transaction with valid attributes" do
        expect {
          post :create, params: { transaction: @transaction_attributes }
        }.to change(Transaction, :count).by(1)
      end

      it "redirects to the transaction's show page after successfully creating the transaction" do
        post :create, params: { transaction: @transaction_attributes }
        expect(response).to redirect_to(transaction_path(assigns(:transaction)))
      end

      it "does not create a new transaction with invalid parameters" do
        user = create(:user)
        book = create(:book)
        sign_in user
        post :create, params: { transaction: { quantity: nil }, book_id: book.id }
        expect(Transaction.count).to eq(0)
      end

      it "re-renders the new transaction page" do
        user = create(:user)
        book = create(:book)
        sign_in user
        post :create, params: { transaction: { quantity: nil }, book_id: book.id }
        expect(response).to render_template(:new)
      end

    end
  end
end


    # it "sets the transaction's total price correctly" do
    #   post
    # end


