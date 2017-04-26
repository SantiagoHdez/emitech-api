import { EmitechClientPage } from './app.po';

describe('emitech-client App', () => {
  let page: EmitechClientPage;

  beforeEach(() => {
    page = new EmitechClientPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
