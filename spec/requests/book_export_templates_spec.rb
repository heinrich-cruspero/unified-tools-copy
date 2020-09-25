 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/book_export_templates", type: :request do
  # BookExportTemplate. As you add validations to BookExportTemplate, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      BookExportTemplate.create! valid_attributes
      get book_export_templates_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      book_export_template = BookExportTemplate.create! valid_attributes
      get book_export_template_url(book_export_template)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_book_export_template_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      book_export_template = BookExportTemplate.create! valid_attributes
      get edit_book_export_template_url(book_export_template)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new BookExportTemplate" do
        expect {
          post book_export_templates_url, params: { book_export_template: valid_attributes }
        }.to change(BookExportTemplate, :count).by(1)
      end

      it "redirects to the created book_export_template" do
        post book_export_templates_url, params: { book_export_template: valid_attributes }
        expect(response).to redirect_to(book_export_template_url(BookExportTemplate.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new BookExportTemplate" do
        expect {
          post book_export_templates_url, params: { book_export_template: invalid_attributes }
        }.to change(BookExportTemplate, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post book_export_templates_url, params: { book_export_template: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested book_export_template" do
        book_export_template = BookExportTemplate.create! valid_attributes
        patch book_export_template_url(book_export_template), params: { book_export_template: new_attributes }
        book_export_template.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the book_export_template" do
        book_export_template = BookExportTemplate.create! valid_attributes
        patch book_export_template_url(book_export_template), params: { book_export_template: new_attributes }
        book_export_template.reload
        expect(response).to redirect_to(book_export_template_url(book_export_template))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        book_export_template = BookExportTemplate.create! valid_attributes
        patch book_export_template_url(book_export_template), params: { book_export_template: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested book_export_template" do
      book_export_template = BookExportTemplate.create! valid_attributes
      expect {
        delete book_export_template_url(book_export_template)
      }.to change(BookExportTemplate, :count).by(-1)
    end

    it "redirects to the book_export_templates list" do
      book_export_template = BookExportTemplate.create! valid_attributes
      delete book_export_template_url(book_export_template)
      expect(response).to redirect_to(book_export_templates_url)
    end
  end
end
