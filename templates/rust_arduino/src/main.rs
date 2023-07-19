#![no_std]
#![no_main]

use core::panic::PanicInfo;

use arduino_hal::{delay_ms, pins, Peripherals};

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[arduino_hal::entry]
fn main() -> ! {
    let peripherals = Peripherals::take().unwrap();
    let pins = pins!(peripherals);

    let mut led = pins.d13.into_output();

    loop {
        led.toggle();
        delay_ms(1000);
    }
}
