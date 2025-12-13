import { useBackend } from 'tgui/backend';
import { Box, Section, ProgressBar, Stack } from 'tgui-core/components';

interface GeoGeneratorData {
  rpm: number;
  output_kw: number;
  max_rpm: number;
  max_output_kw: number;
}

export const GeoTurbineGenerator = () => {
  const { data } = useBackend<GeoGeneratorData>();

  const { rpm, output_kw, max_rpm, max_output_kw } = data;

  const barColor = (pct: number) => {
    if (pct < 50) return 'good';     // green
    if (pct < 80) return 'average';  // amber
    return 'bad';                    // red
  };

  return (
    <Box>
      <Section title="Generator Output">
        <Stack vertical>
          <Stack.Item>
            <b>RPM:</b> {rpm} / {max_rpm}
            <ProgressBar
              value={(rpm / max_rpm) * 100}
              color={barColor((rpm / max_rpm) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Electrical Output:</b> {output_kw} kW / {max_output_kw} kW
            <ProgressBar
              value={(output_kw / max_output_kw) * 100}
              color={barColor((output_kw / max_output_kw) * 100)}
            />
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
};
