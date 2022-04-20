use ::alloc::boxed::Box;

mod alloc;
mod page;

pub fn init() {
    alloc::init();
    page::init();

    // test for alloc
    let a = Box::new(1);
    warn!("the value of box test: {}", a);
}