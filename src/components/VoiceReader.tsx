import { useState, useEffect } from "react";
import { Button } from "@/components/ui/button";
import { Volume2, VolumeX, Pause, Play } from "lucide-react";

interface VoiceReaderProps {
  text: string;
}

export function VoiceReader({ text }: VoiceReaderProps) {
  const [isSpeaking, setIsSpeaking] = useState(false);
  const [isPaused, setIsPaused] = useState(false);

  useEffect(() => {
    return () => {
      window.speechSynthesis.cancel();
    };
  }, []);

  const speak = () => {
    if (!text) return;

    const utterance = new SpeechSynthesisUtterance(text);
    const voices = window.speechSynthesis.getVoices();
    
    // Prefer female voices
    const femaleVoice = voices.find(
      voice => voice.name.toLowerCase().includes('female') || 
               voice.name.toLowerCase().includes('samantha') ||
               voice.name.toLowerCase().includes('zira')
    );
    
    if (femaleVoice) {
      utterance.voice = femaleVoice;
    }

    utterance.rate = 0.9;
    utterance.pitch = 1.0;

    utterance.onstart = () => {
      setIsSpeaking(true);
      setIsPaused(false);
    };

    utterance.onend = () => {
      setIsSpeaking(false);
      setIsPaused(false);
    };

    utterance.onerror = () => {
      setIsSpeaking(false);
      setIsPaused(false);
    };

    window.speechSynthesis.speak(utterance);
  };

  const pause = () => {
    if (window.speechSynthesis.speaking && !window.speechSynthesis.paused) {
      window.speechSynthesis.pause();
      setIsPaused(true);
    }
  };

  const resume = () => {
    if (window.speechSynthesis.paused) {
      window.speechSynthesis.resume();
      setIsPaused(false);
    }
  };

  const stop = () => {
    window.speechSynthesis.cancel();
    setIsSpeaking(false);
    setIsPaused(false);
  };

  if (!isSpeaking) {
    return (
      <Button
        variant="ghost"
        size="sm"
        onClick={speak}
        className="h-7 px-2 text-xs"
      >
        <Volume2 className="h-3 w-3 mr-1" />
        Listen
      </Button>
    );
  }

  return (
    <div className="flex gap-1">
      {isPaused ? (
        <Button
          variant="ghost"
          size="sm"
          onClick={resume}
          className="h-7 px-2 text-xs"
        >
          <Play className="h-3 w-3 mr-1" />
          Resume
        </Button>
      ) : (
        <Button
          variant="ghost"
          size="sm"
          onClick={pause}
          className="h-7 px-2 text-xs"
        >
          <Pause className="h-3 w-3 mr-1" />
          Pause
        </Button>
      )}
      <Button
        variant="ghost"
        size="sm"
        onClick={stop}
        className="h-7 px-2 text-xs"
      >
        <VolumeX className="h-3 w-3 mr-1" />
        Stop
      </Button>
    </div>
  );
}
