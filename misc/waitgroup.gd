class_name Waitgroup

var processes: int
var mx: Mutex
var on_zero: Semaphore

func Add(x: int = 1) -> void:
	mx.lock()
	processes += x
	mx.unlock()

func Sub(x: int = 1) -> void:
	mx.lock()
	processes -= x
	if processes == 0:
		on_zero.post()
	mx.unlock()


func WaitZero() -> void:
	on_zero.wait()


func TryZero() -> bool:
	return on_zero.try_wait() == 0

func _init() -> void:
	processes = 0
	mx = Mutex.new()
	on_zero = Semaphore.new()

