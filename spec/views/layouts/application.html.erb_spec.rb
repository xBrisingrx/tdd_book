require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  it 'render the layout' do
    # allow nos permite agregar los expect de los llamados de las vistas
    # and_call_original nos permite hacer las llamadas de renderizado
    allow(view).to receive(:render).and_call_original
    render

    expect(view).to have_received(:render).with('shared/header')
    expect(view).to have_received(:render).with('shared/side_bar')
    expect(view).to have_received(:render).with('shared/footer')
  end
end
