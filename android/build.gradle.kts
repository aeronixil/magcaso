allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
val sharedBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(sharedBuildDir)
subprojects {
    layout.buildDirectory.value(sharedBuildDir.dir(project.name))
    evaluationDependsOn(":app")
}
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
