extern crate winapi;


fn test_winapi_crate(){
    use std::ffi::CString;
    use winapi::um::winuser::MessageBoxA;
    use winapi::um::winuser::{MB_OK, MB_ICONINFORMATION};
    let lp_text = CString::new("winapi::um::winuser::MessageBoxA").unwrap();
    let lp_caption = CString::new("Hello, winapi!").unwrap();
    unsafe {
        MessageBoxA(
            std::ptr::null_mut(),
            lp_text.as_ptr(),
            lp_caption.as_ptr(),
            MB_OK | MB_ICONINFORMATION
        );
    }    
}

fn test_windows_crate(){
    use windows::Win32::UI::WindowsAndMessaging::MessageBoxA;
    use windows::Win32::Foundation::HWND;
    use windows::Win32::UI::WindowsAndMessaging::{MB_OK, MB_ICONINFORMATION};
    use windows::core::PCSTR;
    use std::ffi::CString;
    let lp_text = CString::new("windows::Win32::UI::WindowsAndMessaging::MessageBoxA").unwrap();
    let lp_caption = CString::new("Hello, windows-rs!").unwrap();
    unsafe {
        MessageBoxA(
            HWND(0),
            PCSTR(lp_text.as_ptr() as *const _),
            PCSTR(lp_caption.as_ptr() as *const _),
            MB_OK | MB_ICONINFORMATION
        );
    }
}


fn main() {
    test_winapi_crate();
    test_windows_crate();
}
