import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { RegistermachineComponent } from './registermachine.component';

describe('RegistermachineComponent', () => {
  let component: RegistermachineComponent;
  let fixture: ComponentFixture<RegistermachineComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ RegistermachineComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(RegistermachineComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
