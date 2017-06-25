import { TestBed, inject } from '@angular/core/testing';

import { RegisterMachineService } from './register-machine.service';

describe('RegisterMachineService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [RegisterMachineService]
    });
  });

  it('should ...', inject([RegisterMachineService], (service: RegisterMachineService) => {
    expect(service).toBeTruthy();
  }));
});
