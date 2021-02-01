
import io.flutter.plugins.GeneratedPluginRegistrant


class Application : FlutterApplication(), PluginRegistrantCallback {
    fun onCreate() {
        super.onCreate()
        AlarmService.setPluginRegistrant(this)
    }

    fun registerWith(registry: PluginRegistry?) {
        GeneratedPluginRegistrant.registerWith(registry)
    }
}