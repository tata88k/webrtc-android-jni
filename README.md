## webrtc-android-jni
webrtc AEC module and its required dependencies module for android.

##How to build WebRTC
* Go to jni folder and run ndk-build
* Copy the resulting .so files from ../libs/[target_architecture] into your Android application project directory

##AEC
```c++
AudioProcessing* apm = AudioProcessing::Create(0);
apm->set_sample_rate_hz(32000);
Super-wideband processing.

// Mono capture and stereo render.
apm->set_num_channels(1, 1);
apm->set_num_reverse_channels(2);
apm->high_pass_filter()->Enable(true);
apm->echo_cancellation()->enable_drift_compensation(false);
apm->echo_cancellation()->Enable(true);
apm->noise_reduction()->set_level(kHighSuppression);
apm->noise_reduction()->Enable(true);
apm->gain_control()->set_analog_level_limits(0, 255);
apm->gain_control()->set_mode(kAdaptiveAnalog);
apm->gain_control()->Enable(true);
apm->voice_detection()->Enable(true);

// Start a voice call...
// ... Render frame arrives bound for the audio HAL ...
apm->AnalyzeReverseStream(render_frame);

// ... Capture frame arrives from the audio HAL ...
// Call required set_stream_ functions.
apm->set_stream_delay_ms(delay_ms);
apm->gain_control()->set_stream_analog_level(analog_level);
apm->ProcessStream(capture_frame);
// Call required stream_ functions.
analog_level = apm->gain_control()->stream_analog_level();
has_voice = apm->stream_has_voice();

// Repeate render and capture processing for the duration of the call...
// Start a new call...
apm->Initialize();

// Close the application...
AudioProcessing::Destroy(apm);
apm = NULL;
```  

[click me !](https://trac.pjsip.org/repos/ticket/1888)

