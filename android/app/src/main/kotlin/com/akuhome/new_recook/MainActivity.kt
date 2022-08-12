package com.akuhome.new_recook
import android.os.Bundle
import android.os.PersistableBundle
import android.view.KeyEvent
import android.view.View
import io.flutter.plugin.common.MethodCall
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import androidx.annotation.NonNull;
class MainActivity : FlutterActivity() {

    //通讯名称,回到手机桌面
    private val CHANNEL = "android/back/desktop"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "backDesktop") {
                result.success(true)
                moveTaskToBack(false)
            }
        }
    }


    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        //GeneratedPluginRegistrant.registerWith(this)
    }
}